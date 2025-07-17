---
title: Projects
layout: page
permalink: /projects/
filter_units: true
---

{% assign todayDate = 'now' | date: '%Y-%m-%d' %}
{% assign currentProjects = "" | split: "" %}
{% assign currentProjectsWithoutEnd = site.data.projects | where_exp: "project", "project.endDate == nil" %}
{% assign currentProjectsWithEnd = site.data.projects | where_exp: "project", "project.endDate >= todayDate" %}
{% if currentProjectsWithoutEnd.size > 0 %}
  {% assign currentProjects = currentProjects | concat: currentProjectsWithoutEnd %}
{% endif %}
{% if currentProjectsWithEnd.size > 0 %}
  {% assign currentProjects = currentProjects | concat: currentProjectsWithEnd %}
{% endif %}
{% assign formerProjects = site.data.projects | where_exp: "project", "project.endDate < todayDate" %}

<h1>Current Projects</h1>
<div>
  {% include list-projects.html source=currentProjects style="card" %}
</div>

<h1>Former Projects</h1>
<div>
  {% include list-projects.html source=formerProjects style="card" %}
</div>