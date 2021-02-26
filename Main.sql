/* do not change the following two lines! */
.header on
.mode column
/* do not change the above two lines! */

/*Task One: List the name of each supplier together with the average price of the products that they supply (round the average to 2 decimal places). */

SELECT supplier.name, round(product.price, 2) AS "Price"
FROM supplier, product
WHERE supplier.supplierID = product.supplierID;

/*Task Two: List the name of each shop together with the largest and the average number of products ordered by the shop (round the average to 1 decimal place). */

SELECT customer.shopName, MAX(orderProduct.quantity) AS "Largest quantity of products ordered", round(avg(orderProduct.quantity), 1) AS "Average quantity of products ordered"
FROM customer, orderProduct, product, supplier
WHERE product.productID = orderProduct.productID AND supplier.supplierID = product.supplierID
GROUP BY customer.shopName ;

/*Task Three: List the name of each shop and the number of orders that the shop has placed. The shop with the largest number of orders should be listed first; shops with the same number of orders should be listed alphabetically.  */

SELECT customer.shopName, COUNT(customerOrder.orderNumber) AS "No. of orders"
FROM customer, customerOrder
WHERE customer.customerID = customerOrder.customerID
GROUP BY customer.shopName
ORDER BY COUNT(customerOrder.orderNumber) DESC, customer.shopName ASC ;

/*Task Four: List each order number together with the number of different products ordered in each order. */

SELECT customerOrder.orderNumber, COUNT(orderProduct.productID) AS "No. of different products"
FROM customerOrder, orderProduct
WHERE  orderProduct.orderNumber = customerOrder.orderNumber
GROUP BY customerOrder.orderNumber ;

/*Task Five: List the name of each supplier together with the total value of the products that they supply. These details should be listed from largest to smallest value. */

SELECT supplier.name, SUM(product.price) AS "Total price of all products"
FROM supplier, product
WHERE supplier.supplierID = product.supplierID
GROUP BY supplier.name
ORDER BY SUM(product.price) DESC ;

/*Task Six: List the name of each product that has been ordered with the combined total quantity of the product that has been ordered. The products should be listed from largest combined total to smallest; product with the same combined total should be listed alphabetically by product name. */

SELECT product.name, SUM(orderProduct.quantity) AS "Total no. of products ordered"
FROM product, orderProduct
WHERE product.productID = orderProduct.productID
GROUP BY product.name
ORDER BY SUM(orderProduct.quantity) DESC, product.name ASC ;

/*Task Seven: List the name of each shop and the total number of bears that have been ordered by the shop. The shop that has ordered the smallest number of bears should be listed first. */

SELECT customer.shopName, COUNT(product.name LIKE "%bear%") AS "Total no. of bears"
FROM customer, product, orderProduct, customerOrder
WHERE customer.customerID = customerOrder.customerID AND customerOrder.orderNumber = orderProduct.orderNumber AND product.productID = orderProduct.productID
GROUP BY customer.shopName
ORDER BY COUNT(product.name) ASC ;

/*Task Eight: List the name of each shop, the order number of any orders placed by the shop, the date and the total cost of those orders. Arrange these details in alphabetical order of shop name; where a shop has placed two or more orders, the most recent order should be listed first.  */

SELECT customer.shopName, customerOrder.orderNumber, customerOrder.orderDate, SUM(product.price) AS "Total cost"
FROM customer, customerOrder, product, orderProduct
WHERE customer.customerID = customerOrder.customerID AND customerOrder.orderNumber = orderProduct.orderNumber AND orderProduct.productID = product.productID
GROUP BY customer.shopName
ORDER BY customer.shopName ASC, customerOrder.orderNumber ASC ; 
