---
layout: page
title: 3 Campbell Street, 3 Campbell Street, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 3 Campbell Street
city: 3 Campbell Street
permalink: /country/new-zealand/manawatu/3-campbell-street/3-campbell-street/
---
[↑ Go to 3 Campbell Street](/country/new-zealand/manawatu/3-campbell-street/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "3 Campbell Street" | where: "city", "3 Campbell Street" %}
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
