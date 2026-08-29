---
layout: page
title: Auckland, Auckland CBD, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Auckland CBD
city: Auckland
permalink: /country/new-zealand/auckland/auckland-cbd/auckland/
---
[↑ Go to Auckland CBD](/country/new-zealand/auckland/auckland-cbd/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Auckland CBD" | where: "city", "Auckland" %}
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
