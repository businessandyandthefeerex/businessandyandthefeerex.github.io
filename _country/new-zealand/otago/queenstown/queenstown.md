---
layout: page
title: Queenstown, Queenstown, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Queenstown
city: Queenstown
permalink: /country/new-zealand/otago/queenstown/queenstown/
---
[↑ Go to Queenstown](/country/new-zealand/otago/queenstown/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Queenstown" | where: "city", "Queenstown" %}
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
