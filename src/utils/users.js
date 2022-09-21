export const userList = [
  {
    username: 'betauser',
    password: 'betauser',
    company: 'acme global',
    beta_access: true
  },
  {
    username: 'normaluser',
    password: 'normaluser',
    company: 'generic co',
    beta_access: false
  },
  {
    username: 'admin',
    password: 'admin',
    company: 'Cool guys',
    betaAccess: true
  }
]

export const betaAccess = () => {
  if (localStorage.getItem('user') === null) {
    return false
  } else {
    let localUser = {}
    userList.map((user) => {
      if (user.username === localStorage.getItem('user')) {
        localUser = user
      }
    })
    return localUser.beta_access
  }
}

export const isLoggedIn = () => {
  return localStorage.getItem('user') !== null
}

export const getCompany = () => {
  if (localStorage.getItem('user') === null) {
    return false
  } else {
    let localUser = {}
    userList.map((user) => {
      if (user.username === localStorage.getItem('user')) {
        localUser = user
      }
    })
    return localUser.company
  }
}
