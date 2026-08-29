---
layout: page
title: Whangārei, Whangārei, Northland, New Zealand
country: New Zealand
region: Northland
suburb: Whangārei
city: Whangārei
permalink: /country/new-zealand/northland/whangārei/whangārei/
---
[↑ Go to Whangārei](/country/new-zealand/northland/whangārei/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Northland" | where: "suburb", "Whangārei" | where: "city", "Whangārei" %}
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
