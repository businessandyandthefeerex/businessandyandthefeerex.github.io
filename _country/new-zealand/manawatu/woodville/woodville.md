---
layout: page
title: Woodville, Woodville, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Woodville
city: Woodville
permalink: /country/new-zealand/manawatu/woodville/woodville/
---
[↑ Go to Woodville](/country/new-zealand/manawatu/woodville/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Woodville" | where: "city", "Woodville" %}
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
