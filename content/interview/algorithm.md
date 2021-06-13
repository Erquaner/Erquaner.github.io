---
title: "算法"
date: 2021-05-04T16:25:20+08:00
draft: false
toc: true
hiddenFromHomePage: true
tags: ["html"]
---

## 排序


### 快排

平均时间复杂度是O(nlogn)，最差时间复杂度是O(n²）。

核心思想是选定一个基准值x，将比x小的值放到左边，比x大的值放到右边。

```js
function swap(arr, i, j) {
  let temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}
function partition(arr, left, right) {
  let index = left + 1;
  let i = index;
  for (i = index; i <= right; i++) {
    if (arr[i] < arr[left]) {
      swap(arr, i, index);
      index++;
    }
  }
  swap(arr, left, index - 1);
  return index - 1;
}

function quickSort(arr, left, right) {
  left = typeof left !== "number" ? 0 : left;
  right = typeof right !== "number" ? arr.length - 1 : right;
  let position = 0;
  if (left < right) {
    position = partition(arr, left, right);
    quickSort(arr, left, position - 1);
    quickSort(arr, position + 1, right);
  }

  return arr;
}
```

### 归并排序

时间复杂度是O(nlogn)。

核心思想是我们递归的将待排序数组分成左右两个数组，一直分到数组只含有一个元素为止，因为数组只含有一个元素，我们就可以认为他是有序的，然后将两个有序表合并成一个有序表。


```js


```

## 反转链表

```js
function reverseList(head) {
  let prev = null, curr = head, temp = null
  while(curr!==null) {
    temp = curr.next
    curr.next = prev
    prev = curr
    curr = temp
  }
  return prev
}

```

## LRU



## 树


### 前序遍历


### 中序遍历


### 后序遍历


### 广度搜索

### 深度搜索



