---
layout: page
title: Newbury, Newbury, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Newbury
city: Newbury
permalink: /country/new-zealand/manawatu/newbury/newbury/
---
[↑ Go to Newbury](/country/new-zealand/manawatu/newbury/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Newbury" | where: "city", "Newbury" %}
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
