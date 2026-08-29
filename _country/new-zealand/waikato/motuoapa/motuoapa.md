---
layout: page
title: Motuoapa, Motuoapa, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Motuoapa
city: Motuoapa
permalink: /country/new-zealand/waikato/motuoapa/motuoapa/
---
[↑ Go to Motuoapa](/country/new-zealand/waikato/motuoapa/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Motuoapa" | where: "city", "Motuoapa" %}
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
