---
layout: page
title: Wānaka, Wānaka, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Wānaka
city: Wānaka
permalink: /country/new-zealand/otago/wānaka/wānaka/
---
[↑ Go to Wānaka](/country/new-zealand/otago/wānaka/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Wānaka" | where: "city", "Wānaka" %}
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
