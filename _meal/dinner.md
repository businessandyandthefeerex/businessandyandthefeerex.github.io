---
layout: page
title: "dinner"
meal: "dinner"
---
[↑ Go to the Meal index](/meal/)

Every post with a dinner for its meal.

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
