import {createContext, useEffect, useState} from "react";

// 컴포넌트 외부에서 createContext 호출
export const UserContext = createContext({
    user: {},
    setUser: () => {},
    allUser: [],
    setAllUser: () => []
});

// eslint-disable-next-line react/prop-types
export function UserContextProvider({children}) {
    const [user, setUser] = useState({});
    const [allUser, setAllUser] = useState([]);
    const [isLoggedIn, setIsLoggedIn] = useState(false);

    useEffect(() => {
        async function checkLogin() {
            try {
                const baseUserInfo = JSON.parse(localStorage.getItem("user") || '{}');
                console.log(baseUserInfo);

                if (baseUserInfo && baseUserInfo.userId) {
                    setUser(baseUserInfo);
                    setIsLoggedIn(true);
                    console.log('Setting user from localStorage:', baseUserInfo);
                } else {
                    setIsLoggedIn(false);
                    console.log('Resetting user state.');
                }

            } catch (error) {
                console.error(error);
            }
        }

        async function getUserInfo() {
            try {
                const response = await fetch('/user/getAllUser');
                if (response.ok === true) {
                    const allUserData = await response.json();
                    setAllUser(allUserData);
                }
            } catch (error) {
                console.error(error);
            }
        }

        checkLogin();
        getUserInfo();
    }, []);


    return (
        <UserContext.Provider value={{user, setUser, allUser, setAllUser, isLoggedIn, setIsLoggedIn}}>
            {children}
        </UserContext.Provider>
    )
}