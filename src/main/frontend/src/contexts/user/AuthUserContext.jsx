import {createContext, useEffect, useState} from "react";

export const initialIsLoggedIn = false;

export const AuthUserContext = createContext(initialIsLoggedIn);

// eslint-disable-next-line react/prop-types
export function AuthUserProvider({children}) {
    const [isLoggedIn, setIsLoggedIn] = useState(initialIsLoggedIn);

    useEffect(() => {
        const checkLogin = async () => {
            try {
                const response = await fetch('/user/checkLogin');

                if (response.ok) {
                    const user = await response.json();

                    // user 객체가 존재하면 로그인 상태로 간주합니다.
                    if (user && user.userId) {
                        setIsLoggedIn(true);
                    } else {
                        setIsLoggedIn(false);
                    }
                } else {
                    setIsLoggedIn(false);
                }
            } catch (error) {
                console.error(error);
                setIsLoggedIn(false);
            }
        };

        checkLogin();

    }, []);

    return (
        <AuthUserContext.Provider value={{isLoggedIn, setIsLoggedIn}}>
            {children}
        </AuthUserContext.Provider>
    )
}