---
layout: page
title: "Reviews"
category: "Reviews"
---
[↑ Go to the Category index](/category/)

Every post with a Reviews for its category.

<ul>
  {% assign current_key = "category" %}
  {% assign current_value = page[current_key] | append: "" %}

  {% for post in site.posts %}
      {% assign post_value = post[current_key] | append: "" %}
      {% if post_value == current_value %}
          <li><a href="{{ post.url }}">{{ post.title }}</a></li>
      {% endif %}
  {% endfor %}
</ul>
