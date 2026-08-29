---
layout: page
title: Dunedin, Dunedin, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Dunedin
city: Dunedin
permalink: /country/new-zealand/otago/dunedin/dunedin/
---
[↑ Go to Dunedin](/country/new-zealand/otago/dunedin/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Dunedin" | where: "city", "Dunedin" %}
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
