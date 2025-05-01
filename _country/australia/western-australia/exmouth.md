---
layout: page
title: Exmouth, Western Australia, Australia
country: Australia
region: Western Australia
suburb: Exmouth
permalink: /country/australia/western-australia/exmouth/
---
[↑ Go to Western Australia](/country/australia/western-australia/)

{% assign posts = site.posts | where: "country", "Australia" | where: "region", "Western Australia" | where: "suburb", "Exmouth" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
  <h4>Rating: {{ group.name }}</h4>
  <ul>
    {% for post in group.items %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
