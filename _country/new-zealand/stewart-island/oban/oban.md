---
layout: page
title: Oban, Oban, Stewart Island, New Zealand
country: New Zealand
region: Stewart Island
suburb: Oban
city: Oban
permalink: /country/new-zealand/stewart-island/oban/oban/
---
[↑ Go to Oban](/country/new-zealand/stewart-island/oban/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Stewart Island" | where: "suburb", "Oban" | where: "city", "Oban" %}
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
