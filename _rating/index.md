---
layout: page
title: "Rating Index"
permalink: /rating/
---

This is the index page for the `rating` collection.

<ul>
    {% assign all_values = site.rating | sort: "title" %}
    {% for item in all_values %}
        {% unless item.url == page.url %}
            <li><a href="{{ item.url }}">{{ item.title }}</a></li>
        {% endunless %}
    {% endfor %}
</ul>
