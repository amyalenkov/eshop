function sortBy(typeSort){
    document.cookie = "sort_by="+typeSort;
    console.log(typeSort);
    if (typeSort=="by_line"){
        document.cookie = "class_for_sort_by=product_in_line";
    }
}
