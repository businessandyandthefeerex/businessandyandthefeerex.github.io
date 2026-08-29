---
layout: page
title: Māngere, Auckland, New Zealand
country: New Zealand
region: Auckland
city: Māngere
permalink: /country/new-zealand/auckland/māngere/
---
[↑ Go to Auckland](/country/new-zealand/auckland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "city", "Māngere" %}
{% assign suburb_groups = posts | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
  {% if group.name != "" %}
    <h4><a href="/country/new-zealand/auckland/{{ group.name | downcase | slugify }}/" style="color: var(--heading-color);">{{ group.name }}</a></h4>
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
