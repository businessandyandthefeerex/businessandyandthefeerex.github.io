---
layout: page
title: Christchurch, Sydenham, New Zealand
country: New Zealand
region: Sydenham
suburb: Christchurch
permalink: /country/new-zealand/sydenham/christchurch/
---
[↑ Go to Sydenham](/country/new-zealand/sydenham/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Sydenham" | where: "suburb", "Christchurch" %}
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
