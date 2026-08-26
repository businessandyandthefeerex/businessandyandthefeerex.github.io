---
layout: page
title: Cooks Beach, Coromandel, New Zealand
country: New Zealand
region: Coromandel
suburb: Cooks Beach
permalink: /country/new-zealand/coromandel/cooks-beach/
---
[↑ Go to Coromandel](/country/new-zealand/coromandel/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Coromandel" | where: "suburb", "Cooks Beach" %}
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
