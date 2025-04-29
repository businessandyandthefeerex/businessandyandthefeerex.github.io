---
layout: page
title: "Reviews from August 2021"
permalink: /reviews/2021/08/
year: 2021
month: 08
---
[↑ Go to 2021](/reviews/2021/)

{% assign this_year = page.year | plus: 0 %}
{% assign this_month = page.month | plus: 0 %}
<ul>
    {% for post in site.posts %}
        {% assign review_year = post.date | date: "%Y" | plus: 0 %}
        {% assign review_month = post.date | date: "%m" | plus: 0 %}
        {% if review_year == this_year and review_month == this_month %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
