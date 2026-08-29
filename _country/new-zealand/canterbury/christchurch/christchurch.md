---
layout: page
title: Christchurch, Christchurch, Canterbury, New Zealand
country: New Zealand
region: Canterbury
suburb: Christchurch
city: Christchurch
permalink: /country/new-zealand/canterbury/christchurch/christchurch/
---
[↑ Go to Christchurch](/country/new-zealand/canterbury/christchurch/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Canterbury" | where: "suburb", "Christchurch" | where: "city", "Christchurch" %}
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
