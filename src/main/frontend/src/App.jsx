import { BrowserRouter, Routes, Route } from 'react-router-dom';
import GetUser from "./pages/user/GetUser.jsx";
import { UserContextProvider } from "./contexts/user/UserContext.jsx";
import Home from "./pages/Home.jsx";
import { ProductContextProvider } from "./contexts/product/ProductContext.jsx";
import GetProductList from "./pages/product/GetProductList.jsx";
import GetProduct from "./pages/product/GetProduct.jsx";
import NavBar from "./components/skeleton/NavBar.jsx";
import { useEffect } from "react";
import "./App.css";

function App() {
    useEffect(() => {
        const unloadHandler = () => {
            localStorage.removeItem("user");
        };

        window.addEventListener("unload", unloadHandler);

        return () => {
            window.removeEventListener("unload", unloadHandler);
        };
    }, []);


    return (
        <BrowserRouter>
            <div className="content-below-navbar"> {/* 이 div를 추가하여 내용을 감쌉니다. */}
                {/* User 라우팅 */}
                <UserContextProvider>
                        <NavBar />
                    <Routes>
                        <Route index element={<Home />} />
                        {/* 다른 라우트들을 여기에 추가 */}
                        <Route path="/user/getUser" element={<GetUser />} />
                    </Routes>
                </UserContextProvider>

                {/* Product 라우팅 */}
                <ProductContextProvider>
                    <Routes>
                        <Route path="/product/getProductList" element={<GetProductList />} />
                    </Routes>
                </ProductContextProvider>

                <Routes>
                    <Route path="/product/getProduct/:query" element={<GetProduct />} />
                </Routes>
            </div> {/* 감싸는 div 종료 */}
        </BrowserRouter>
    );
}

export default App;
