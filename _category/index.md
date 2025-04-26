---
layout: page
title: "Category Collection"
permalink: /category/
---
[↑ Go to the collections page](/collections/)

Every value used for the category collection.

<ul>
  {% assign current_key = "category" %}
  {% assign is_numeric = false %}
  {% if current_key == "rating" %}
    {% assign is_numeric = true %}
  {% endif %}
  
  {% assign all_values = site.posts | map: current_key | uniq %}
  
  {% if is_numeric %}
    {% assign all_values = all_values | sort | reverse %}
  {% else %}
    {% assign all_values = all_values | sort %}
  {% endif %}

  {% for value in all_values %}
    {% assign slug = value | append: "" | slugify %}
    <li>
      <a href="/category/{{ slug }}/">
        {{ current_key | capitalize }}: {{ value | capitalize }}
      </a>
    </li>
  {% endfor %}
</ul>
