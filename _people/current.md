---
title: People
layout: page
permalink: /people/
---

{% assign detailsCenter = "picture, internalUnit, email, phone, personalPage" | split: ", " %}
{% assign detailsUnits = "picture, internalUnit, email, phone" | split: ", " %}

<h1>Research Center</h1>
<h2>Director</h2>
{% include list-people.html source=site.data.members.members_cs.current.head style="card" details=detailsCenter sort="none" %}

<h2>Members</h2>
{% include list-people.html source=site.data.members.members_cs.current.members style="card" details=detailsCenter %}

<h1>Research Units</h1>
<h2>Heads</h2>
{% assign unitHeads = "" | split: "" %}
{% for file in site.data.members %}
    {% if file[0] != "members_cs" %}
        {% for head in file[1].current.head %}
            {% assign unitHeads = unitHeads | push: head %}
        {% endfor %}
    {% endif %}
{% endfor %}
{% include list-people.html source=unitHeads style="card" details=detailsUnits %}

<h2>Members</h2>
{% assign unitMembers = "" | split: "" %}
{% for file in site.data.members %}
    {% if file[0] != "members_cs" %}
        {% for member in file[1].current.members %}
            {% assign unitMembers = unitMembers | push: member %}
        {% endfor %}
    {% endif %}
{% endfor %}
{% include list-people.html source=unitMembers style="card" details=detailsUnits %}

<h2>Collaborators</h2>
{% assign unitCollaborators = "" | split: "" %}
{% for file in site.data.members %}
    {% if file[0] != "members_cs" %}
        {% for collaborator in file[1].current.collaborators %}
            {% assign unitCollaborators = unitCollaborators | push: collaborator %}
        {% endfor %}
    {% endif %}
{% endfor %}
{% include list-people.html source=unitCollaborators style="card" details=detailsUnits %}