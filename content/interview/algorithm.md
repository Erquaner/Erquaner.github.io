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
function merge(a, b) {
  let i = 0,
    j = 0;
  let aLength = a?.length || 0,
    bLength = b?.length || 0;
  let newArr = [];
  while (i < aLength && j < bLength) {
    if (a[i] <= b[j]) {
      newArr.push(a[i]);
      i++;
    } else {
      newArr.push(b[j]);
      j++;
    }
  }

  //a还剩一些
  if (i < aLength && j === bLength) {
    while (i < aLength) {
      newArr.push(a[i]);
      i++;
    }
  }

  //b还剩一些
  if (j < bLength && i === aLength) {
    while (j < bLength) {
      newArr.push(b[j]);
      j++;
    }
  }
  return newArr;
}
function mergeSort(arr) {
  if (arr.length <= 1) {
    return arr;
  }
  const middle = Math.floor(arr.length / 2);
  const left = arr.slice(0, middle);
  const right = arr.slice(middle);

  return merge(mergeSort(left), mergeSort(right));
}


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





## 树


### 前序遍历


### 中序遍历


### 后序遍历


### 广度搜索

### 深度搜索



## LRU

```js
/**
 * @param {number} capacity
 */
var LRUCache = function(capacity) {
        this.capacity = capacity;
        this.cache = new Map();
};
/** 
 * @param {number} key
 * @return {number}
 */
LRUCache.prototype.get = function(key) {
       if(!this.cache.has(key)) return -1;
        const value = this.cache.get(key);
        this.cache.delete(key);
        this.cache.set(key, value);
        return value;
};

/** 
 * @param {number} key 
 * @param {number} value
 * @return {void}
 */
LRUCache.prototype.put = function(key, value) {
    if(this.cache.has(key)){
        this.cache.delete(key);
    }else{
        if(this.cache.size === this.capacity){
            // 获取到Map中第一个数据的key值，即最近最少访问的key，删之
            const delKey = this.cache.keys().next().value;
            this.cache.delete(delKey);
        }
    }
    this.cache.set(key, value);
};
```