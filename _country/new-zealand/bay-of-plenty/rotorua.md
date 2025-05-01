---
layout: page
title: Rotorua, Bay of Plenty, New Zealand
country: New Zealand
region: Bay of Plenty
suburb: Rotorua
permalink: /country/new-zealand/bay-of-plenty/rotorua/
---
[↑ Go to Bay of Plenty](/country/new-zealand/bay-of-plenty/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Bay of Plenty" | where: "suburb", "Rotorua" %}
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
