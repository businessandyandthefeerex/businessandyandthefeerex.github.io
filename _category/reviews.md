---
layout: page
title: "Category: Reviews"
category: "Reviews"
---
[↑ Go to the Category collection](/category/)

Every post with the value Reviews for the category collection.

<ul>
  {% assign current_key = "category" %}
  {% assign current_value = page[current_key] | append: "" %}
  {% assign matching_posts = site.posts | where: current_key, current_value | sort: "title" %}

  {% for post in matching_posts %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
