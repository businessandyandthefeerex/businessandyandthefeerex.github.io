---
layout: page
title: "Reviews from November 2020"
permalink: /reviews/2020/11/
year: 2020
month: 11
---
[↑ Go to 2020](/reviews/2020/)

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
