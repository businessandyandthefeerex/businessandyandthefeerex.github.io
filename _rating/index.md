---
layout: page
title: "Rating Collection"
permalink: /rating/
---

Every value used for the rating collection.

<ul>
  {% assign current_key = "rating" %}
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
      <a href="/rating/{{ slug }}/">
        {{ current_key | capitalize }}: {{ value | capitalize }}
      </a>
    </li>
  {% endfor %}
</ul>
