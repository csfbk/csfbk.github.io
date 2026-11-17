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
      chunks = [+"# Auto-merged from _data/single/#{foldername}/*.yml\n"]

      extract = lambda do |record, pattern|
        val = record[pattern, 1].to_s.sub(/,\z/, "").gsub(/\A["']|["']\z/, "").strip
        val.empty? ? nil : val
      end

      files.each do |file|
        filename = File.basename(file)
        chunks << "\n## From file: #{filename}\n"

        File.read(file).split(/^(?=- )/).each do |record|
          entry = {
            text: record,
            filename: filename,
            dropped: false,
            doi: nil,
            id_iris: nil,
            id: nil
          }

          if dedup
            entry[:doi] = extract.call(record, /^[ \t]*-?[ \t]*doi:[ \t]*(.+?)[ \t]*\r?$/i)&.downcase
            entry[:id_iris] = extract.call(record, /^[ \t]*-?[ \t]*id_iris:[ \t]*["']?([0-9]+),?["']?,?[ \t]*\r?$/i)
            entry[:id] = extract.call(record, /^[ \t]*-?[ \t]*id:[ \t]*(.+?)[ \t]*\r?$/i)

            keys = []
            keys << [:doi, entry[:doi]] if entry[:doi]
            keys << [:id_iris, entry[:id_iris]] if entry[:id_iris]
            keys << [:id, entry[:id]] if entry[:id]

            matched_entries = keys.filter_map { |k| seen[k] }.uniq

            if matched_entries.any?
              matched_field = keys.find { |k| seen.key?(k) }.first
              candidates = matched_entries + [entry]

              # Prefer the first record that has id_iris; otherwise keep the earliest record
              winner = candidates.find { |c| !c[:id_iris].nil? } || candidates.first

              candidates.each do |c|
                next if c.equal?(winner) || c[:dropped]

                c[:dropped] = true
                label = c[:id] || c[:id_iris] || c[:doi]
                reason = if winner.equal?(entry)
                           "replaced by entry with id_iris from #{filename}"
                         else
                           "duplicate field #{matched_field}"
                         end
                Jekyll.logger.warn "MergeData:", "Dropping duplicate record #{label} from #{c[:filename]} (#{reason})"
              end

              # Link every identifier from all matched records to the winning entry
              candidates.each do |c|
                seen[[:doi, c[:doi]]] = winner if c[:doi]
                seen[[:id_iris, c[:id_iris]]] = winner if c[:id_iris]
                seen[[:id, c[:id]]] = winner if c[:id]
              end
            else
              keys.each { |k| seen[k] = entry }
            end
          end
          chunks << entry
        end
      end

      content = chunks.map { |c| c.is_a?(Hash) ? (c[:dropped] ? "" : c[:text]) : c }.join
      content << "\n"

      write_if_changed.call(output_path, content)
    end
  end
end