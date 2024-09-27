---
title: People
layout: page
permalink: /people/
---

<h1>Research Center</h1>
<h2>Director</h2>
{% assign details = "picture, email, phone, personalPage" | split: ", " %}
{% include list-people.html source=site.data.members.members_cs.current.head style="card" details=details sort="none" %}

<h2>Members</h2>
{% assign details = "picture, internalRole, email, phone, personalPage" | split: ", " %}
{% include list-people.html source=site.data.members.members_cs.current.members style="card" details=details %}

<h1>Research Units</h1>
<h2>Heads</h2>
{% assign details = "picture, internalUnit, email, phone" | split: ", " %}
{% assign unitHeads = "" | split: "" %}
{% for file in site.data.members %}
    {% if file[0] != "members_cs" %}
        {% for head in file[1].current.head %}
            {% assign unitHeads = unitHeads | push: head %}
        {% endfor %}
    {% endif %}
{% endfor %}
{% include list-people.html source=unitHeads style="card" details=details %}

<h2>Members</h2>
{% assign details = "picture, internalRole, internalUnit, email, phone" | split: ", " %}
{% assign unitMembers = "" | split: "" %}
{% for file in site.data.members %}
    {% if file[0] != "members_cs" %}
        {% for member in file[1].current.members %}
            {% assign unitMembers = unitMembers | push: member %}
        {% endfor %}
    {% endif %}
{% endfor %}
{% include list-people.html source=unitMembers style="card" details=details %}

<h2>Collaborators</h2>
{% assign details = "picture, role, institution, email, phone" | split: ", " %}
{% assign unitCollaborators = "" | split: "" %}
{% for file in site.data.members %}
    {% if file[0] != "members_cs" %}
        {% for collaborator in file[1].current.collaborators %}
            {% assign unitCollaborators = unitCollaborators | push: collaborator %}
        {% endfor %}
    {% endif %}
{% endfor %}
{% include list-people.html source=unitCollaborators style="card" details=details %}