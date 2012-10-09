array = [1,2,3,4]
length = array.length-1

(array.length/2).times { | index |
    j = array[index]
    k = array[length-index]

    array[index] = k
    array[length-index] = j
}
p array
