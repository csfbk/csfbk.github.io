---
title: Curricular Internships
subtitle: Current Projects
layout: page
permalink: /internships/
---

This page lists the internship projects currently available in the Center for Cybersecurity of [Fondazione Bruno Kessler](https://www.fbk.eu) (FBK). Please note that these are <b>curricular internship projects</b> (which does not include financial compensation) <b>intended specifically for bachelor's and master's university students</b>, and not employment contracts. Please refer to [jobs.fbk.eu](https://jobs.fbk.eu/) for job offers and open positions.

{% include toc.md %}

<div class="columns is-multiline">
<div class="column is-6 is-flex is-flex-direction-column" markdown="1">
<div class="notification is-primary is-flex-grow-1">
    <h1 class="text-inherit">Procedure</h1>
    <ol class="mt-0">
        <li><b>Application</b>: submit your application for the internship project you are interested in using the <b><a href="https://forms.gle/woK1EtSbHPcrVohu8">designated online form</a></b> and providing the required information by the specified deadline. You are advised <u>not</u> to apply to more than two projects at the same time.</li>
        <li><b>Selection</b>: project supervisors will review the applications and choose the most suitable candidate. Each project is evaluated independently.</li>
        <li><b>Results</b>: once the selection process is complete, all applicants will be notified of the outcome for the specific project.</li>
    </ol>
</div>
</div>

<div class="column is-6 is-flex is-flex-direction-column" markdown="1">
<div class="notification is-warning is-flex-grow-1">
    <h1 class="text-inherit">Contact Information</h1>
    <p>Depending on your question, please reach out to the appropriate contact:</p>
    <ol class="mt-0">
        <li><strong>General internship questions:</strong> <a href="mailto:internships-cs@fbk.eu">internships-cs@fbk.eu</a></li>
        <li><strong>Administrative and funding matters</strong> (such as Erasmus+ eligibility): <a href="mailto:scholar@fbk.eu">scholar@fbk.eu</a></li>
        <li><strong>Project-related questions:</strong> reach out directly to the supervisor(s).</li>
    </ol>
    <p>Please note that applications sent via email will <u>not</u> be considered.</p>
</div>
</div>

<div class="column is-12 mt-2 mb-4" markdown="1">
# Available Internships

{% assign todayDate = "now" | date: "%Y-%m-%d %H:%M" %}
{%- if page.year -%}
    {%- assign internships = site.data.internships.projects | where_exp: "project", "project.year == page.year" | where_exp: "project", "project.applicationEnd < todayDate" -%}
    {%- include list-internships.html source=internships sort_by="title" -%}
{%- else -%}
    {%- assign internships = site.data.internships.projects | where_exp: "project", "project.applicationEnd >= todayDate" -%}
    {%- if internships and internships.size > 0 -%}
        <p>Projects are listed starting with those that have the earliest submission deadlines.</p>
        {%- include list-internships.html source=internships -%}
    {%- else -%}
        *No open internships at the moment, but stay tuned! New projects are added regularly, so be sure to check back soon. In the meantime, see the [awards](#hall-of-fame) our students have won and explore our [recent projects](#recent-projects) to get an idea of past topics.*
    {%- endif -%}
{%- endif %}

</div>

<div class="column is-12 mt-4" markdown="1">
<hr class="mt-3 mb-6">

# Hall of Fame

A collection of student theses carried out with our group that have received awards or special recognition. A complete list of the theses developed at our Center is available on the [dedicated page](/theses).

{% assign thesesWithAwards = site.data.theses | where_exp: "thesis", "thesis.awards" %}
{::nomarkdown}
{%- include list-theses.html source=thesesWithAwards sort_by="year" sort_reverse=true -%}
{:/nomarkdown}
</div>

<div class="column is-12" markdown="1">

# Recent Projects

Our three most recent projects. While they are no longer open for applications, they give a good idea of the research topics and tasks we typically offer. You can find earlier projects in our [archive](/internships/archive).

{% assign lastInternships = site.data.internships.projects | where_exp: "project", "project.applicationEnd < todayDate" | sort: "applicationEnd" | reverse | slice: 0, 3 %}
{::nomarkdown}
{%- include list-internships.html source=lastInternships -%}
{:/nomarkdown}
</div>
</div>
