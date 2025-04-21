---
layout: page
title: "Meal Index"
permalink: /meal/
---

Every value used for the meal collection.

<ul>
  {% assign all_values = site.meal | sort: "title" %}
  {% for item in all_values %}
    {% unless item.url == page.url %}
      {% assign title_str = item.title | append: "" %}
      <li>
        <a href="{{ item.url }}">
          {% if title_str != "" %}
            {% if title_str contains ' ' %}
              {{ title_str | split: ' ' | map: 'capitalize' | join: ' ' }}
            {% else %}
              {{ title_str | capitalize }}
            {% endif %}
          {% else %}
            (No title)
          {% endif %}
        </a>
      </li>
    {% endunless %}
  {% endfor %}
</ul>
