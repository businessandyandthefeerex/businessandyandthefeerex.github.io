---
layout: page
title: Wellington, Strathmore Park, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Strathmore Park
city: Wellington
permalink: /country/new-zealand/wellington/strathmore-park/wellington/
---
[↑ Go to Strathmore Park](/country/new-zealand/wellington/strathmore-park/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Strathmore Park" | where: "city", "Wellington" %}
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
