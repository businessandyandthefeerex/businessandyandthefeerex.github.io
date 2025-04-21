---
layout: page
title: "Category Index"
permalink: /category/
---

This is the index page for the `category` collection.

<ul>
    {% assign all_values = site.category | sort: "title" %}
    {% for item in all_values %}
        {% unless item.url == page.url %}
            <li><a href="{{ item.url }}">{{ item.title }}</a></li>
        {% endunless %}
    {% endfor %}
</ul>
