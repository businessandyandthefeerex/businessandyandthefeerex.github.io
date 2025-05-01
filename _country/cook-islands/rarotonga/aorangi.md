---
layout: page
title: Aorangi, Rarotonga, Cook Islands
country: Cook Islands
region: Rarotonga
suburb: Aorangi
permalink: /country/cook-islands/rarotonga/aorangi/
---
[↑ Go to Rarotonga](/country/cook-islands/rarotonga/)

{% assign posts = site.posts | where: "country", "Cook Islands" | where: "region", "Rarotonga" | where: "suburb", "Aorangi" %}
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
