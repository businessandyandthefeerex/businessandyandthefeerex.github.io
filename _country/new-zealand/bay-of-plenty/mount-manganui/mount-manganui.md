---
layout: page
title: Mount Manganui, Mount Manganui, Bay of Plenty, New Zealand
country: New Zealand
region: Bay of Plenty
suburb: Mount Manganui
city: Mount Manganui
permalink: /country/new-zealand/bay-of-plenty/mount-manganui/mount-manganui/
---
[↑ Go to Mount Manganui](/country/new-zealand/bay-of-plenty/mount-manganui/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Bay of Plenty" | where: "suburb", "Mount Manganui" | where: "city", "Mount Manganui" %}
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
