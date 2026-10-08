Jekyll::Hooks.register :site, :after_reset do |site|
  single_root = File.join(site.source, "_data", "single")
  next unless Dir.exist?(single_root)

  write_if_changed = lambda do |path, content|
    if File.exist?(path) && File.read(path) == content
      # unchanged — skip write, avoid re-triggering the watcher
      next
    end
    Jekyll.logger.info "MergeData:", "Writing #{path}"
    File.write(path, content)
  end

  Dir.glob(File.join(single_root, "*/")).each do |dir|
    foldername = File.basename(dir)
    files = Dir.glob(File.join(dir, "*.yml")).sort

    if files.empty?
      Jekyll.logger.info "MergeData:", "No YAML files found in #{dir}, skipping."
      next
    end

    if foldername == "members"
      output_path = File.join(site.source, "_data", "members_units.yml")

      content = +"units:\n"
      files.each do |file|
        filename = File.basename(file)
        content << "\n"
        content << "## From file: #{filename}\n"
        content << "  -\n"
        File.readlines(file).each { |line| content << "    #{line}" }
        content << "\n"
      end

      write_if_changed.call(output_path, content)

    else
      output_path = File.join(site.source, "_data", "#{foldername}.yml")

      # Publications and theses are sourced per unit; the same record (same id_iris, or
      # same id when there is no id_iris) can be listed in more than one unit
      # file. Keep the first occurrence only.
      dedup = %w[publications theses].include?(foldername)
      seen = {}
      content = +"# Auto-merged from _data/single/#{foldername}/*.yml\n"
      files.each do |file|
        filename = File.basename(file)
        content << "\n"
        content << "## From file: #{filename}\n"
        File.read(file).split(/^(?=- )/).each do |record|
          key = nil
          if dedup
            key = record[/^[ \t]*-?[ \t]*id_iris:[ \t]*(.+?)[ \t]*$/, 1] ||
                  record[/^[ \t]*-?[ \t]*id:[ \t]*(.+?)[ \t]*$/, 1]
            key = key.to_s.sub(/,\z/, "").gsub(/\A"|"\z/, "").strip unless key.nil?
          end
          if key && seen.key?(key)
            Jekyll.logger.warn "MergeData:", "Dropping duplicate record #{key} from #{filename}"
          else
            seen[key] = true if key
            content << record
          end
        end
      end
      content << "\n"

      write_if_changed.call(output_path, content)
    end
  end
end