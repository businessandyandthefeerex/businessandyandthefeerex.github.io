---
layout: page
title: "Meal: Lunch"
meal: "lunch"
---
[↑ Go to the Meal collection](/meal/)

Every post with the value lunch for the meal collection.

<ul>
  {% assign current_key = "meal" %}
  {% assign current_value = page[current_key] | append: "" %}

  {% for post in site.posts %}
      {% assign post_value = post[current_key] | append: "" %}
      {% if post_value == current_value %}
          <li><a href="{{ post.url }}">{{ post.title }}</a></li>
      {% endif %}
  {% endfor %}
</ul>
