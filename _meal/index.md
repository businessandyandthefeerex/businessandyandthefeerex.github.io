---
layout: page
title: "Meal Collection"
permalink: /meal/
---

Every value used for the meal collection.

<ul>
  {% assign current_key = "meal" %}
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
      <a href="/meal/{{ slug }}/">
        {{ current_key | capitalize }}: {{ value | capitalize }}
      </a>
    </li>
  {% endfor %}
</ul>
