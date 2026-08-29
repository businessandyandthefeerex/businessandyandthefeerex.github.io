---
layout: page
title: Invercargill, Southland, New Zealand
country: New Zealand
region: Southland
city: Invercargill
permalink: /country/new-zealand/southland/invercargill/
---
[↑ Go to Southland](/country/new-zealand/southland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Southland" | where: "city", "Invercargill" %}
{% assign suburb_groups = posts | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
  {% if group.name != "" %}
    <h4><a href="/country/new-zealand/southland/{{ group.name | downcase | slugify }}" style="color: var(--heading-color);">{{ group.name }}</a></h4>
  {% else %}
    <h4>Unspecified suburb</h4>
  {% endif %}

  {% assign rating_groups = group.items | group_by: "rating" %}
  {% assign sorted_rating_groups = rating_groups | sort: "name" %}

  {% for rating_group in sorted_rating_groups reversed %}
    <h5>Rating: {{ rating_group.name }}</h5>
    <ul>
      {% for post in rating_group.items %}
        <li><a href="{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
  {% endfor %}
{% endfor %}
