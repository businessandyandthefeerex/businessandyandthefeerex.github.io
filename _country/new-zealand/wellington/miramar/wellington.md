---
layout: page
title: Wellington, Miramar, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Miramar
city: Wellington
permalink: /country/new-zealand/wellington/miramar/wellington/
---
[↑ Go to Miramar](/country/new-zealand/wellington/miramar/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Miramar" | where: "city", "Wellington" %}
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
