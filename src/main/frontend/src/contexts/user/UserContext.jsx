import {createContext, useEffect, useState} from "react";

// 컴포넌트 외부에서 createContext 호출
export const UserContext = createContext({
    user: {},
    setUser: () => {},
    allUser: []
});

// eslint-disable-next-line react/prop-types
export function UserContextProvider({children}) {
    const [user, setUser] = useState({});
    const [allUser, setAllUser] = useState([]);

    useEffect(  () => {
        async function checkLogin() {
            try {
                const response = await fetch('/user/checkLogin');
                const contentType = response.headers.get('Content-Type');

                if (contentType && response.ok && contentType.includes('application/json')) {
                    const loggedInUser = await response.json();
                    setUser(loggedInUser);
                }
            } catch (error) {
                console.error(error);
            }
        } // end of checkLogin

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
        <UserContext.Provider value={{user, setUser, allUser, setAllUser}}>
            {children}
        </UserContext.Provider>
    )
}