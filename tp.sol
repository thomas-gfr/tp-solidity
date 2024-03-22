// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
contract VotingSystem {
    // Struct pour représenter un candidat
    struct Candidate {
        uint id; // Identifiant du candidat
        string name; // Nom du candidat
        uint voteCount; // Nombre de votes reçus par le candidat
    }
 
    // Mapping pour stocker les candidats avec l'identifiant du candidat comme clé et la struct Candidate comme valeur
    mapping(uint => Candidate) public candidates;
 
    // Tableau d'identifiants de candidats pour faciliter l'itération
    uint[] public candidateIds;
 
    // Mapping des électeurs avec l'adresse de l'électeur comme clé et une valeur booléenne indiquant si l'électeur a voté
    mapping(address => bool) public voters;
 
    // Adresse du propriétaire du contrat
    address public owner;
 
    // Constructeur du contrat pour initialiser le propriétaire
    constructor() {
        owner = msg.sender; // L'adresse de la personne qui déploie le contrat est définie comme propriétaire
    }
 
    // Fonction pour ajouter un candidat
    function addCandidate(uint _id, string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates"); // Vérifier que seule le propriétaire peut ajouter des candidats
        candidates[_id] = Candidate(_id, _name, 0); // Créer un nouvel objet Candidat et l'ajouter au mapping des candidats
        candidateIds.push(_id); // Ajouter l'identifiant du candidat au tableau d'identifiants de candidats
    }
 
    // Fonction pour permettre à un électeur de voter pour un candidat
    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted"); // Vérifier que l'électeur n'a pas déjà voté
        require(candidates[_candidateId].id != 0, "Candidate does not exist"); // Vérifier que le candidat existe
        candidates[_candidateId].voteCount++; // Incrémenter le nombre de votes reçus par le candidat
        voters[msg.sender] = true; // Marquer l'électeur comme ayant voté
    }
}