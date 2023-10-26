import {createContext, useEffect, useState} from "react";

export const ProductContext = createContext({
    product: {},
    setProduct: () => {},
    allProduct: []
})

// eslint-disable-next-line react/prop-types
export function ProductContextProvider({children}) {

    const [product, setProduct] = useState({});
    const [allProduct, setAllProduct] = useState([]);

    useEffect(() => {

        async function getProductInfo() {
            try {

                const response = await fetch('/product/getProductList');
                if (response.ok === true) {
                    const allProductData = await response.json();
                    setAllProduct(allProductData);
                }

            } catch (error) {
                console.log(error);
            }
        }

        getProductInfo();
    }, []);


    return (
        <ProductContext.Provider value={{product, setProduct, allProduct, setAllProduct}}>
            {children}
        </ProductContext.Provider>
    )
}