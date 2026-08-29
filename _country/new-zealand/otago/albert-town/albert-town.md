---
layout: page
title: Albert Town, Albert Town, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Albert Town
city: Albert Town
permalink: /country/new-zealand/otago/albert-town/albert-town/
---
[↑ Go to Albert Town](/country/new-zealand/otago/albert-town/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Albert Town" | where: "city", "Albert Town" %}
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
