---
layout: page
title: "Suburb Index"
permalink: /suburb/
---

This is the index page for the `suburb` collection.

<ul>
    {% assign all_values = site.suburb | sort: "title" %}
    {% for item in all_values %}
        {% unless item.url == page.url %}
            <li><a href="{{ item.url }}">{{ item.title }}</a></li>
        {% endunless %}
    {% endfor %}
</ul>
