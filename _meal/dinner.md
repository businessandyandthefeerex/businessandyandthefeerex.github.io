---
layout: page
title: "Meal: Dinner"
meal: "dinner"
---
[↑ Go to the Meal collection](/meal/)

Every post with the value dinner for the meal collection.

<ul>
  {% assign current_key = "meal" %}
  {% assign current_value = page[current_key] | append: "" %}
  {% assign matching_posts = site.posts | where: current_key, current_value | sort: "title" %}

  {% for post in matching_posts %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
