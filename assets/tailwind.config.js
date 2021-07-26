module.exports = {
  purge: [
    '../lib/**/*.ex',
    '../lib/**/*.leex',
    '../lib/**/*.eex',
    './js/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#009d57",
          light: "#a6ce39",
        },
        secondary: {
          DEFAULT: "#0e51a1",
          light: "#00aeef"
        }
      },
    },
  },
  variants: {},
  plugins: []
};