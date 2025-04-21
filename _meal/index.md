---
layout: page
title: "Meal Index"
permalink: /meal/
---

This is the index page for the `meal` collection.

<ul>
    {% assign all_values = site.meal | sort: "title" %}
    {% for item in all_values %}
        {% unless item.url == page.url %}
            <li><a href="{{ item.url }}">{{ item.title }}</a></li>
        {% endunless %}
    {% endfor %}
</ul>
