---
layout: page
title: Swan Valley, Western Australia, Australia
country: Australia
region: Western Australia
suburb: Swan Valley
permalink: /country/australia/western-australia/swan-valley/
---
[↑ Go to Western Australia](/country/australia/western-australia/)

{% assign posts = site.posts | where: "country", "Australia" | where: "region", "Western Australia" | where: "suburb", "Swan Valley" %}
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
